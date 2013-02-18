require 'socket'

port = (ENV['PORT'] || 8080).to_i

loop do
  puts "Listening on #{port} ..."
  server = TCPServer.new(port)

  server.setsockopt(Socket::SOL_SOCKET,Socket::SO_REUSEADDR, true)

  linger = [1, 0].pack('ii')
  server.setsockopt(Socket::SOL_SOCKET, Socket::SO_LINGER, linger)

  client = server.accept
  server.close

  puts "Client waiting ..."
  sleep 3
  client.puts "HTTP 200 OK\r\n"
  client.puts "\r\n"
  client.puts "Hello World"
  client.close
  puts "Client done."
end
