require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "タイトル",	with: "書類作成"
        fill_in "内容",	with: "企画書を作成する"
        click_on "登録する" #showへのvisitは書かなくてOK？
        expect(page).to have_content "書類作成"
        expect(page).to have_content "企画書を作成する"
      end
    end
  end
  describe '一覧表示機能' do
    let!(:task) { FactoryBot.create(:task, title:'勉強',content:'Rubyを学ぶ'} #一覧表示機能内の処理の共通化
    before do
      visit tasks_path #一覧表示機能内の処理の共通化
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content "書類作成"
        expect(page).to have_content "メール送信"
        expect(page).to have_content "勉強"
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        task_0 = task_list[0]
        expect(task_0).to have_content "勉強"
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title:'勉強', content:'Rubyを学ぶ')
        visit task_path(task.id)
        expect(page).to have_content '勉強'
      end
    end
  end
end