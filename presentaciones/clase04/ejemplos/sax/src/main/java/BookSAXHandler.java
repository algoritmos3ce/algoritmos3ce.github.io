import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;

import java.util.ArrayList;
import java.util.List;

public class BookSAXHandler extends DefaultHandler {

    private final List<Book> books = new ArrayList<>();
    private Book currentBook;
    private final StringBuilder content = new StringBuilder();

    public List<Book> getBooks() {
        return books;
    }

    @Override
    public void startElement(String uri, String localName,
                             String qName, Attributes attributes) {

        if ("book".equalsIgnoreCase(qName)) {
            currentBook = new Book();
        }

        content.setLength(0); // clear buffer
    }

    @Override
    public void characters(char[] ch, int start, int length) {
        content.append(ch, start, length);
    }

    @Override
    public void endElement(String uri, String localName, String qName) {

        switch (qName.toLowerCase()) {

            case "title":
                currentBook.title = content.toString().trim();
                break;

            case "author":
                currentBook.author = content.toString().trim();
                break;

            case "book":
                books.add(currentBook);
                break;
        }
    }
}
