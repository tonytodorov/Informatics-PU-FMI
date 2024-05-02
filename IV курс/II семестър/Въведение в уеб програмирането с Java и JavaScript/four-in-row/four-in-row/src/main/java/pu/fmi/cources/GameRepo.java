package pu.fmi.cources;

import java.util.UUID;

public interface GameRepo {

	void save(Game game);

	void delete(Game game);

	Game get(UUID gameId);

}