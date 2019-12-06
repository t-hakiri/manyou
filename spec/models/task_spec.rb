require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do

  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(title: '', content: '失敗テスト', deadline: Date.today, status: '完成', priority: '高')
    expect(task).not_to be_valid
  end

  it 'titleが30文字以上ならバリデーションが通らない' do
    task = Task.new(title: 'a'*31, content: '失敗テスト', deadline: Date.today, status: '完成', priority: '高')
    expect(task).not_to be_valid
  end

  it 'contentが255文字以上ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: 'a'*256, deadline: Date.today, status: '完成', priority: '高')
    expect(task).not_to be_valid
  end

  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: '', deadline: Date.today, status: '完成', priority: '高')
    expect(task).not_to be_valid
  end

  it 'deadlineが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: '失敗テスト', deadline: "", status: '完成', priority: '高')
    expect(task).not_to be_valid
  end

  it 'statusが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: '失敗テスト', deadline: Date.today, status: '', priority: '高')
    expect(task).not_to be_valid
  end

  it 'priorityが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: '失敗テスト', deadline: Date.today, status: '完成', priority: '')
    expect(task).not_to be_valid
  end

  it '全ての内容が記載されていればバリデーションが通る' do
    task = Task.new(title: '失敗テスト', content: '失敗テスト', deadline: Date.today, status: '完成', priority: '高')
    expect(task).to be_valid
  end

  it '作成日の降順でタスクをソート' do
    @tasks = Task.all.sorted.page
    expect(@tasks).to eq @tasks.order(created_at: :desc)
  end

  it '終了期限の降順でタスクをソート' do
    @tasks = Task.all.deadline_sort
    expect(@tasks).to eq @tasks.order(deadline: :desc)
  end

  it '優先度の昇順でタスクをソート' do
    @tasks = Task.all.sort_priority
    expect(@tasks).to eq @tasks.order(priority: :asc)
  end

  it 'タイトル検索で任意の文字を入力し、それに近いタスクのみを表示' do
    @task = FactoryBot.create(:task)
    @second_task = FactoryBot.create(:second_task)
    expect(Task.title_search("second")).to include(@second_task)
    expect(Task.title_search("second")).to_not include(@task)
  end

  it 'ステータス検索で選択した値のみを表示' do
    @task = FactoryBot.create(:task)
    @second_task = FactoryBot.create(:second_task)
    expect(Task.status_search("完了")).to include(@second_task)
    expect(Task.status_search("完了")).to_not include(@task)
  end
end