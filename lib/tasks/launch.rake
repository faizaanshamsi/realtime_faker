namespace :run do
  namespace :forrest do
    task :run do
      pids = []

      number_of_servers = ARGV.last.to_i

      1.upto(number_of_servers) do |x|
        port = 3000 + x
        pids << spawn("bundle exec rails server Puma -p #{port} -b 127.0.0.1 --pid tmp/pids/server#{x}.pid")
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
