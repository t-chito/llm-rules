```ruby
RSpec.describe "DiscountCombinationCalculator" do
  # 共通メソッド定義
  # let(:user) { create(:user, rank: :gold) }
  # let(:product) { create(:product, price: 50000) }
  # let(:calculator) { DiscountCombinationCalculator.new(user, product) }

  context "基本割引の組み合わせ" do
    context "会員割引と金額別割引の組み合わせ" do
      specify "両方の割引が適用される" do
        # 15%(ゴールド) + 3%(5万円以上) = 18%の割引が適用されることを検証
      end
    end

    context "キャンペーン割引との組み合わせ" do
      specify "キャンペーン割引が他の割引と併用される" do
        # キャンペーン10% + 会員15% = 25%の割引が適用されることを検証
      end
    end
  end

  context "排他的な割引の制限" do
    context "特別セールとキャンペーンの同時適用" do
      specify "より高い割引率の方が優先される" do
        # 特別セール30% vs キャンペーン10% → 30%が適用されることを検証
      end
    end

    context "VIP限定割引と会員割引の排他制御" do
      specify "VIP限定割引が優先され、会員割引は無効化される" do
        # VIP25%が適用され、通常の会員割引15%は適用されないことを検証
      end
    end
  end

  context "割引率の上限制御" do
    context "複数割引の合計が上限を超える場合" do
      specify "割引率が50%で上限制御される" do
        # 会員20% + 金額5% + キャンペーン30% = 55% → 50%に制限されることを検証
      end
    end

    context "単一割引が上限を超える場合" do
      specify "単一割引でも上限が適用される" do
        # 特別セール60% → 50%に制限されることを検証
      end
    end
  end

  context "優先順位ルール" do
    context "同じ優先度の割引が複数存在する場合" do
      specify "割引率の高い方が選択される" do
        # 同優先度のキャンペーンA(15%) vs キャンペーンB(20%) → B(20%)が適用
      end
    end

    context "異なる優先度の割引が存在する場合" do
      specify "優先度の高い割引が選択される" do
        # 高優先度の会員割引15% vs 低優先度の特別セール25% → 会員割引15%が適用
      end
    end
  end

  context "境界値での組み合わせ" do
    context "割引率が0%の場合" do
      specify "0%割引は他の割引に影響を与えない" do
        # 0%割引 + 会員15% = 15%の割引が適用されることを検証
      end
    end

    context "商品価格が0円の場合" do
      specify "無料商品には割引が適用されない" do
        # 価格0円の商品では割引計算が実行されないことを検証
      end
    end
  end

  context "特殊な組み合わせパターン" do
    context "期間限定とクーポンの組み合わせ" do
      specify "期間限定割引とクーポンが併用される" do
        # 期間限定10% + クーポン500円 = 両方が適用されることを検証
      end
    end

    context "複数クーポンの制限" do
      specify "クーポンは1つまでしか適用できない" do
        # 複数クーポンが存在する場合、最も有利なもの1つだけが適用されることを検証
      end
    end
  end
end
```
