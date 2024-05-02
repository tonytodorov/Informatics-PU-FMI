import java.util.Scanner;
import java.util.Set;

public class Main {
    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);

        InformationRetrievalSystem irs = new InformationRetrievalSystem();

        Document doc1 = new Document(1, "Java is a programming language.");
        Document doc2 = new Document(2, "Java is used for building web applications.");
        Document doc3 = new Document(3, "Python is another programming language.");

        irs.indexDocument(doc1);
        irs.indexDocument(doc2);
        irs.indexDocument(doc3);

        Set<Document> result = irs.search(scanner.nextLine());

        if (!result.isEmpty()) {
            result.forEach(document ->
                    System.out.println("Document " + document.getId() + ": " + document.getContent()));
        } else {
            System.out.println("No matches!");
        }
    }
}