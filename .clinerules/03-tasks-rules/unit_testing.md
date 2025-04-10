# 単体テスト作成ルール

## 基本方針

- テストは「何をテストしているか」が明確に伝わるように記述する
- 実装の詳細に依存せず、期待する動作に焦点を当てたテストを書く
- テストケースは境界値や特殊ケースを含め、機能を網羅的にカバーする

## テスト名と構造

- 具体的な期待値を含めたテスト名を使用する（例：`returns ["order", 2021-01-01, 2021-01-31 23:59:59] for January 2021`）
- `context` ブロックでテスト条件を明確に区分する

## 期待値の設定

- 実装をコピーした期待値（`Date.new(2021, 1, 31).end_of_day`）は避け、具体的な値または個別の属性で検証する
```ruby
expect(end_date.year).to eq(2021)
expect(end_date.month).to eq(1)
expect(end_date.day).to eq(31)
```
- 環境依存の値（タイムゾーン、マイクロ秒）は直接比較しない

## 境界値とエラーケース

- 境界値（数値の最小/最大、日付の月末/月初、閏年）をテストする
- エラーケースをテストする
```ruby
expect { controller.send(:get_filter_date_range, 'order_invalid_month') }.to raise_error(ArgumentError)
```

## テストの網羅性

- 網羅性チェックを実装し、新しい条件追加時にテストが失敗するようにする
```ruby
it 'tests all booking statuses' do
  explicitly_tested_statuses = %i[pending? approve? decline?]
  all_statuses = Booking.statuses.keys.map { |s| "#{s}?".to_sym }
  expect(all_statuses - explicitly_tested_statuses).to be_empty
end
```
- テストケースは独立させ、状態を共有しない

## プライベートメソッドとモック

- プライベートメソッドは `send` メソッドでテストする
- 外部依存はモックまたはスタブで分離し、最小限に抑える
