require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title:'', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title:'失敗テスト', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトル、詳細、終了期限、ステータス、優先順位に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title:'成功テスト', content: '成功テスト', expired_at: '2022-10-31', status:'着手', priority:'高') 
        #終了期限とステータスをモデルのバリデーションに含めるかどうか
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, title: 'task_1', status:'着手') }
    let!(:second_task) { FactoryBot.create(:second_task, title: 'task_2', status:'完了')}
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.title_search('task_1')).to include(task)
        expect(Task.title_search('task_1')).not_to include(second_task)
        expect(Task.title_search('task_1').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_search('着手')).to include (task)
        expect(Task.status_search('着手')).not_to include (second_task)
        expect(Task.status_search('着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.title_search('task_2')).to include(second_task)
        expect(Task.status_search('完了')).to include(second_task)
        expect(Task.title_search('task_2')).not_to include(task)
        expect(Task.status_search('完了')).not_to include(task)
        expect(Task.title_search('task_2').count).to eq 1
        expect(Task.status_search('完了').count).to eq 1
      end
    end
  end
end