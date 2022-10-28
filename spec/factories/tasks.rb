FactoryBot.define do
  factory :task do
    title { '書類作成' } #fakerの値を使うこともできる
    content { '企画書を作成する' } 
    expired_at {'2022-11-01'}
  end

  factory :second_task, class: Task do #Taskはモデル
    title { 'メール送信' }
    content { '顧客へ営業のメールを送る'}
    expired_at {'2022-10-01'}
  end
end