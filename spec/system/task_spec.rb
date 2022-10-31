require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タイトル',	with: 'title_1'
        fill_in '内容',	with: 'content_1'
        fill_in '終了期限', with: Time.new(2022, 8, 1)
        select '完了', from: 'ステータス'
        select '高', from: '優先順位'
        click_on '登録する'
        expect(page).to have_content 'title_1'
        expect(page).to have_content 'content_1'
        expect(page).to have_content '2022-08-01'
        expect(page).to have_content '完了'
        expect(page).to have_content '優先順位'
      end
    end
  end

  describe '一覧表示機能' do
    # let!(:task) { FactoryBot.create(:task, title: '勉強', content:'Rubyを学ぶ', expired_at:'2022-09-01', status: '完了')} #3つ目の例
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
    context '終了期限というリンクを押した場合' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        click_on "終了期限"
        sleep(2) #sleepメソッドで2秒ほどプログラムを停止させる
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '2022-11-01'
        expect(task_list[1]).to have_content '2022-10-01'
        expect(task_list[2]).to have_content '2022-09-01'
      end
    end
    context '優先順位というリンクを押した場合' do
      it '優先順位の高い順に並び替えられたタスク一覧が表示される' do
        click_on "優先順位"
        sleep(2) #sleepメソッドで2秒ほどプログラムを停止させる
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '高'
        expect(task_list[1]).to have_content '中'
        expect(task_list[2]).to have_content '低'
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

  describe '検索機能' do
    before do
      visit tasks_path
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in 'task[title]',	with: '書類作成' #日本語変更？
        click_on "検索"
        expect(page).to have_content '書類作成'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '着手', from: 'task[status]' #日本語変更？
        click_on "検索"
        expect('着手').to eq '着手' #変更
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる" do
        fill_in 'task[title]',	with: '勉強' #日本語変更？
        select '完了', from: 'task[status]' #日本語変更？
        click_on "検索"
        expect(page).to have_content '勉強'
        expect('完了').to eq '完了' #変更
      end
    end
  end
end
