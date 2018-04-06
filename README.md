# Tekcal
* 某システムのカレンダーをスクレイピングで取得してきてical形式に変換するツールです
* google カレンダーからエクスポートしたものと抽出したCSVのカレンダーをマージします(予定)

# インストール
```
brew install geckodriver
brew cask install firefiox
bundle install
```
```
cp config.sample.yml config.yml
edit config.yml
```

# 実行方法
```
bundle exec ruby app.rb
cat schedule.csv
```
