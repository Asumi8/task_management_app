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
        fill_in 'タイトル',	with: 'title_1'
        fill_in '内容',	with: 'content_1'
        fill_in '終了期限', with: Time.new(2022, 9, 1)
        click_on '登録する'
        expect(page).to have_content 'title_1'
        expect(page).to have_content 'content_1'
        expect(page).to have_content '2022-09-01'
      end
    end
  end

  describe '一覧表示機能' do
    let!(:task) { FactoryBot.create(:task, title: '勉強', content:'Rubyを学ぶ', expired_at:'2022-09-01') } #3つ目の例
    before do
      visit tasks_path
    end

    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content '勉強'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '勉強'
        expect(task_list[1]).to have_content 'メール送信'
        expect(task_list[2]).to have_content '書類作成'
      end
    end
    context '終了期限でソートするというリンクを押した場合' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        click_on '終了期限でソートする'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '書類作成'
        expect(task_list[1]).to have_content 'メール送信'
        expect(task_list[2]).to have_content '勉強'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task)
        visit task_path(task.id)
        expect(page).to have_content '書類作成'
      end
    end
  end
end