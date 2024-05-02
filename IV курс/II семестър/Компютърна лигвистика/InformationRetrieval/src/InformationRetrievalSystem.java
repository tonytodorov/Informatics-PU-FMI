import java.util.*;

public class InformationRetrievalSystem {

    private Map<String, Set<Document>> index;

    public InformationRetrievalSystem() {
        index = new HashMap<>();
    }

    public void indexDocument(Document document) {
        String[] words = document.getContent().split("\\s+");

        Arrays.stream(words).forEach(word -> {
            word = word.toLowerCase();
            index.computeIfAbsent(word, key -> new HashSet<>()).add(document);
        });
    }

    public Set<Document> search(String query) {
        Set<Document> result = new HashSet<>();
        String[] queryWords = query.split("\\s+");

        Arrays.stream(queryWords).forEach(word -> {
            word = word.toLowerCase();

            if (index.containsKey(word)) {
                result.addAll(index.get(word));
            }
        });

        return result;
    }
}