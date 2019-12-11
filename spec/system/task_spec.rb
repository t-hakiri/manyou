require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    # 「タスク一覧画面」や「タスク詳細画面」などそれぞれのテストケースで、before内のコードが実行される
    # 各テストで使用するタスクを1件作成する
    # 作成したタスクオブジェクトを各テストケースで呼び出せるようにインスタンス変数に代入
    @label = FactoryBot.create(:label)
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user2)
    @task = FactoryBot.create(:task, user_id: @user.id )
    @task3 = FactoryBot.create(:task3, user_id: @user.id )
    @second_task = FactoryBot.create(:second_task, user_id: @user2.id )

    visit new_session_path

    fill_in 'session_email', with: 'test7@aa.aa'
    fill_in 'session_password', with: 'testtesttest'  
    click_on 'Log in'
  end
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      # テストコードを it '~' do end ブロックの中に記載する
      it '作成済みのタスクが表示されること' do
        # テストで使用するためのタスクを作成
        # タスク一覧ページに遷移
        visit tasks_path 
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        # あらかじめタスク並び替えの確認テストで使用するためのタスクを二つ作成する
        # （上記と全く同じ記述が繰り返されてしまう！）

        visit tasks_path 
        task_list = all('#task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'task3'
        expect(task_list[1]).to have_content 'task'
      end
    end

    context '終了期限でソートするを押した場合' do
      it 'タスクが終了期限の降順で並んでいること' do 
        visit tasks_path
        click_on '終了期限でソートする'
        sleep 1

        task_list = all('#task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'task3'
        expect(task_list[1]).to have_content 'task'
      end
    end
    context '優先順位でソートするを押した場合' do
      it 'タスクが優先順位の降順で並んでいること' do
        visit tasks_path
        click_on '優先順位でソートする'
        sleep 1

        task_list = all('#task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'task3'
        expect(task_list[1]).to have_content 'task'
      end
    end
    context '任意の文字列で検索した時' do
      it '任意の文字列を含むタスクのみが表示されていること' do
        visit tasks_path
        fill_in "タイトル検索", with: '3'
        click_button '検索する'
        sleep 1

        task_list = all('#task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'task3'
      end
    end
    context 'ステータスの検索した時' do
      it '選択したステータスのタスクのみが表示されていること' do
        visit tasks_path
        select '完了', from: 'ステータス検索'
        sleep 1
        click_button '検索する'

        task_list = all('#task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'task3'
      end
    end

    context 'ラベルを新規作成して' do
      it '一覧画面でラベル検索かけたとき' do
        visit new_task_path
        fill_in 'タイトル', with: 'label_test'      
        fill_in '内容', with: 'bbb'
        select '2017', from: 'task_deadline_1i'
        select '11', from: 'task_deadline_2i'
        select '3', from: 'task_deadline_3i'
        select '完了', from: 'task_status'
        select '中', from: 'task_priority'
        check '仕事'
        sleep 1
        click_button '登録する'

        select '仕事', from: 'ラベル検索'
        click_button '検索する'

        sleep 3

        expect(page).to have_content '仕事'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        # new_task_pathにvisitする（タスク登録ページに遷移する）
        # 1.ここにnew_task_pathにvisitする処理を書く
        visit new_task_path
        # 「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄に
        # タスクのタイトルと内容をそれぞれfill_in（入力）する
        # 2.ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in 'タイトル', with: 'aaa'      
        # 3.ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in '内容', with: 'bbb'
        select '2017', from: 'task_deadline_1i'
        select '11', from: 'task_deadline_2i'
        select '3', from: 'task_deadline_3i'
        select '完了', from: 'task_status'
        select '中', from: 'task_priority'
        sleep 1
        # 「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
        # 4.「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
        click_button '登録する'
        # clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        # 5.タスク詳細ページに、テストコードで作成したはずのデータ（記述）がhave_contentされているか（含まれているか）を確認（期待）するコードを書く
        expect(page).to have_content 'aaa'
        expect(page).to have_content 'bbb'
      end
    end
  end

  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移すること' do
        visit task_path(@task)
        expect(page).to have_content @task.title
        expect(page).to have_content @task.content
      end
    end
  end
end