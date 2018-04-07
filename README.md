# Tekucal
* 某システムのカレンダーをスクレイピングで取得してきてical形式に変換するツール
* Googleカレンダーを使っているなら、インポート用カレンダーに追加する運用がおすすめ
  * 出力するイベントには、ユニークキー的なものを持っていないので、日付変更すると上書きされずに重複するため、いつでも削除できるインポート用カレンダーにまず取り込むとよい

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
bundle exec ./bin/run
cat schedule.ical
```

* ブラウザが某システムにログインしてスケジュールをcsvを書き出す
* 書き出したcsvをical形式に変換する

ということを `./bin/run` がやります
