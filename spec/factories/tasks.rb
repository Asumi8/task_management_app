FactoryBot.define do
  factory :task do
    title { '書類作成' } #fakerの値を使うこともできる
    content { '企画書を作成する' } #step3:終了期限のカラムの追加
  end

  factory :second_task, class: Task do #Taskはモデル
    title { 'メール送信' }
    content { '顧客へ営業のメールを送る'}
  end
end