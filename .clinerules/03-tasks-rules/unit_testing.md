# 単体テスト作成ルール

## 基本方針

- テストは「何をテストしているか」が明確に伝わるように記述する
- 実装の詳細に依存せず、期待する動作に焦点を当てたテストを書く
- テストケースは境界値や特殊ケースを含め、機能を網羅的にカバーする

## テスト名と構造

1. **具体的なテスト名**
   - 曖昧な名前（例：`returns something`）ではなく、具体的な期待値を含めた名前にする
   - 例：`returns ["order", 2021-01-01, 2021-01-31 23:59:59] for January 2021`

2. **テスト構造**
   - `context` ブロックでテスト条件を明確に区分する
   - 関連するテストケースは同じ `context` 内にグループ化する
   - 条件分岐や境界値ごとに別の `context` を用意する

## 期待値の設定

1. **明示的な期待値**
   - 実装をコピーした期待値（例：`Date.new(2021, 1, 31).end_of_day`）は避ける
   - 代わりに具体的な値を使用するか、個別の属性ごとに検証する
   ```ruby
   # 良い例
   expect(end_date.year).to eq(2021)
   expect(end_date.month).to eq(1)
   expect(end_date.day).to eq(31)
   ```

2. **環境依存の回避**
   - タイムゾーンやマイクロ秒の精度など、環境によって異なる可能性がある値は直接比較しない
   - 代わりに必要な属性のみを個別に検証する

## 境界値と特殊ケース

1. **境界値のテスト**
   - 数値の最小値/最大値
   - 日付の月末/月初
   - 閏年の2月29日など特殊な日付

2. **エラーケースのテスト**
   - 無効な入力に対して適切なエラーが発生することを確認
   - 例：
   ```ruby
   expect {
     controller.send(:get_filter_date_range, 'order_invalid_month')
   }.to raise_error(ArgumentError)
   ```

## テストの網羅性

1. **網羅性チェック**
   - 新しい条件や状態が追加された場合にテストが失敗するようにする
   - 例：ステータスの網羅性チェック
   ```ruby
   it 'tests all booking statuses defined in the model' do
     explicitly_tested_statuses = %i[pending? approve? decline?]
     all_statuses = Booking.statuses.keys.map { |s| "#{s}?".to_sym }
     untested_statuses = all_statuses - explicitly_tested_statuses
     expect(untested_statuses).to be_empty
   end
   ```

2. **テストケースの独立性**
   - 各テストケースは他のテストに依存せず、単独で実行できるようにする
   - テスト間で状態を共有しない

## プライベートメソッドのテスト

1. **アクセス方法**
   - プライベートメソッドは `send` メソッドを使用してテストする
   ```ruby
   result = controller.send(:get_filter_date_range, 'order_2021_1')
   ```

2. **テスト対象の選定**
   - 複雑なロジックを含むプライベートメソッドはテスト対象とする
   - 単純なヘルパーメソッドは公開メソッドを通じて間接的にテストする

## モック・スタブの使用

1. **外部依存のモック化**
   - 外部サービスやデータベースへの依存はモックまたはスタブを使用して分離する
   - 例：
   ```ruby
   allow(booking).to receive(:total_price).and_return(total_price)
   ```

2. **適切なモックの粒度**
   - テスト対象の振る舞いに集中できる最小限のモックを使用する
   - 過剰なモックは実装の詳細に依存してしまう原因になるため避ける

これらのルールに従うことで、堅牢で保守性の高いテストコードを作成できます。テストは実装の詳細ではなく、期待される動作に焦点を当て、明確で理解しやすいものにしましょう。
