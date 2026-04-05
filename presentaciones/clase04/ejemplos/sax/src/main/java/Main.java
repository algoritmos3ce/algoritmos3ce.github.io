import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import java.util.List;

public class Main {
    public static void main(String[] args) throws Exception {
        BookSAXHandler handler = new BookSAXHandler();

        SAXParser parser = SAXParserFactory.newInstance().newSAXParser();
        parser.parse("books.xml", handler);

        List<Book> books = handler.getBooks();
        for (Book b : books)
            System.out.println(b);
    }
}
