FactoryBot.define do
  factory :task do
    title { '書類作成' } #fakerの値を使うこともできる
    content { '企画書を作成する' } 
    expired_at {'2022-11-01'}
    status {'未着手'}
    priority {'低'}
  end

  factory :second_task, class: Task do #Taskはモデル
    title { 'メール送信' }
    content { '顧客へ営業のメールを送る'}
    expired_at {'2022-10-01'}
    status {'着手'}
    priority {'高'}
  end
  
  factory :third_task, class: Task do #Taskはモデル
    title { '勉強' }
    content { 'Rubyを学ぶ'}
    expired_at {'2022-09-01'}
    status {'完了'}
    priority {'中'}
  end
end