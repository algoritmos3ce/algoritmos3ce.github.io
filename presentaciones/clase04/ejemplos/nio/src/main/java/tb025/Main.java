package tb025;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.nio.charset.Charset;

public class Main {
    public static final int PORT = 5000;

    public static void echoServer() throws IOException {
        try (var server = ServerSocketChannel.open()) {
            server.bind(new InetSocketAddress(PORT));
            System.out.printf("listening on %s\n", server.getLocalAddress());

            ByteBuffer buf = ByteBuffer.allocate(1024);

            while (true) {
                try (var client = server.accept()) {
                    System.out.printf("new client connected: %s\n", client.getRemoteAddress());

                    while (true) {
                        buf.clear();
                        int n = client.read(buf);
                        if (n < 0) {
                            System.out.printf("client disconnect: %s\n", client.getRemoteAddress());
                            break;
                        }
                        if (n > 0) {
                            buf.flip();
                            System.out.printf("read from %s: %s\n", client.getRemoteAddress(), Charset.defaultCharset().decode(buf));

                            buf.flip();
                            client.write(buf);
                        }
                    }
                }
            }
        }
    }

    public static void echoServerMultiplexado() throws IOException {
        try (ServerSocketChannel server = ServerSocketChannel.open();
             Selector selector = Selector.open()) {

            server.bind(new InetSocketAddress(PORT));
            System.out.printf("listening on %s\n", server.getLocalAddress());

            server.configureBlocking(false);
            server.register(selector, SelectionKey.OP_ACCEPT);

            while (true) {
                selector.select();

                var selectedKeys = selector.selectedKeys().iterator();
                while (selectedKeys.hasNext()) {
                    SelectionKey key = selectedKeys.next();
                    selectedKeys.remove();

                    if (key.isAcceptable()) {
                        SocketChannel client = server.accept();
                        System.out.printf("new client connected: %s\n", client.getRemoteAddress());
                        client.configureBlocking(false);
                        client.register(selector, SelectionKey.OP_READ);
                    }

                    if (key.isReadable()) {
                        ByteBuffer buf = ByteBuffer.allocate(1024);
                        SocketChannel client = (SocketChannel) key.channel();
                        int n = client.read(buf);
                        if (n < 0) {
                            System.out.printf("client disconnect: %s\n", client.getRemoteAddress());
                            client.close();
                            break;
                        }
                        if (n > 0) {
                            buf.flip();
                            System.out.printf("read from %s: %s\n", client.getRemoteAddress(), Charset.defaultCharset().decode(buf));

                            buf.flip();
                            client.write(buf);
                        }
                    }
                }
            }
        }
    }

    public static void main(String[] args) throws IOException, InterruptedException {
        echoServer();
    }
}
