---
description: unit testing and regression protection for software
---

# test command

- test-strategy-planner
- unit-test-designer
- unit-test-implementer

エージェントを使用して、単体テストを実装してください。

## DoD（Definition of Done）

### テストそのものへの要求から

- [ ] 全てのテストが実装され、かつパスしていること
- [ ] テストケースのタイトル、内部のコメント、実装内容、期待値が矛盾なく整合していること
- [ ] テストコードの記述が機能の振る舞いのみに着目しており、実装の詳細に依存した記述が存在しないこと
- [ ] 外部依存がない限り、モックを使用していないこと

### テストの保守性の観点から

- [ ] Arrange, Act, Assert パターンに従っていること
- [ ] テストの構造を自然言語で追試できるだけのコメントが記されていること
- [ ] Act, Assert がシンプルなロジックとなっており、 Arrange も可能な限り共通化、簡素化されていること
