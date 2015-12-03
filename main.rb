require 'pry-byebug'
require 'sinatra'
require 'sinatra/contrib/all' if development?
require 'pg'

get '/tasks' do
  #Get all the task from DB

  sql = "SELECT * FROM tasks;"
  @tasks = run_sql(sql)
  erb :index
end

get '/tasks/new' do
  # Render a form
  erb :new
end

post '/tasks' do
  # Persist new task to DB
  name = params[:name]
  details = params[:details]
  sql = "INSERT INTO tasks (name, details) VALUES ('#{name}' , '#{details}')"
  run_sql(sql)
  redirect to('/tasks')
end

get '/tasks/:id' do
  # Grad task from DB where id = :id

  sql = "SELECT * FROM tasks WHERE id = #{params[:id]}"
  @task = run_sql(sql).first
  erb :show
end

get '/tasks/:id/edit' do
  #Grab item from DB and render form
  sql = "SELECT * FROM tasks WHERE id = #{params[:id]}"
  @task = run_sql(sql).first
  erb :edit
end

post '/tasks/:id' do
  #Grab params and update in DB
end

post '/tasks/:id/delete' do
  #Destroy in DB
end

def run_sql(sql)
  conn = PG .connect(dbname: 'todo' , host: 'localhost')

  result = conn.exec(sql)
  conn.close
  result
end

