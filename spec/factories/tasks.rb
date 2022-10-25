FactoryBot.define do
  factory :task do
    # 作成するテストデータの名前を「task」とします
    # 「task」のように実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを作成されます
    title { '書類作成' } #fakerの値を使うこともできる
    content { '企画書を作成する' }
  end

  factory :second_task, class: Task do
    # 作成するテストデータの名前を「second_task」とします
    # 「second_task」のように存在しないクラス名をつける場合、`class`オプションを使ってどのクラスのテストデータを作成するかを明示する必要がります
    title { 'メール送信' }
    content { '顧客へ営業のメールを送る'}
  end
end