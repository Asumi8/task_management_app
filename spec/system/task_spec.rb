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
        fill_in "Title",	with: "書類作成" #ちゃんと表示されている通り、大文字で
        fill_in "Content",	with: "企画書を作成する" #ちゃんと表示されている通り、大文字で
        click_on "Create Task" #showへのvisitは書かなくてOK？
        expect(page).to have_content "書類作成"
        expect(page).to have_content "企画書を作成する"
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title:'書類作成', content:'企画書を作成する')
        visit tasks_path
        expect(page).to have_content '書類作成'
        expect(page).to have_content "企画書を作成する"
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title:'書類作成', content:'企画書を作成する')
        visit task_path(task.id)
        expect(page).to have_content '書類作成'
        expect(page).to have_content "企画書を作成する"
      end
    end
  end
end