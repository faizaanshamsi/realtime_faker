namespace :run do
  namespace :forrest do
    task :run do
      pids = []

      (1..6).each do |x|
        pids << spawn("bundle exec rails server Puma -p 300#{x} -b 127.0.0.1 --pid tmp/pids/server#{x}.pid")
      end

      trap 'INT' do
        Process.kill 'INT', *pids
        exit 1
      end

      loop do
        sleep 1
      end
    end
  end
end
