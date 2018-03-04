class Exporter
  include Capybara::DSL

  def initialize(config)
    Capybara.visit(config["login_url"])
    Capybara.fill_in(:session_email, with: config["email"])
    Capybara.fill_in(:session_password, with: config["password"])
    Capybara.click_button "ログインする"
    @schedule_list = []
  end

  def run
    Capybara.visit File.join([Capybara.current_host, '/mentor/schedule'])
    Capybara.click_link "確定シフト一覧"
    run_suhuto
    run_mentoring
    data = @schedule_list.join("\n")
    File.write("schedule.csv", data)
    data
  end

  private

  def run_mentoring
    current_date = today
    5.times do
      Capybara.visit File.join([Capybara.current_host, 
                                "/mentor/schedule/appointments/#{current_date.year}/#{current_date.month}"])
      list = Capybara.find_all("table tbody tr")
      puts "今月(#{current_date.year}/#{current_date.month})は#{list.size}件のメンタリングがあります"
      list.each do |tr|
        td_list = tr.find_all("td").map { |x| x.text }
        next if td_list.empty?
        date_with_range = td_list[0]
        mentie_name = td_list[1]
        @schedule_list << [date_with_range, mentie_name, "メンタリング"].join(",")
      end
      current_date = current_date.next_month
    end
  end

  def run_suhuto
    list = Capybara.find_all("table tbody tr")
    puts "今月(#{today.year}/#{today.month})は#{list.size}件のシフトがあります"
    list.each do |tr|
      td_list = tr.find_all("td").map { |x| x.text }
      next if td_list.empty?
      date = td_list[0]
      time_range = td_list[1]
      @schedule_list << [date, time_range, "シフト"].join(",")
    end
  end

  def today
    @today ||= Date.today
  end
end
