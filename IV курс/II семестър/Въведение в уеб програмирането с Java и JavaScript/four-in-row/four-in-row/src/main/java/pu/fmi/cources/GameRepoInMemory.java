package pu.fmi.cources;

import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;

// @Repository
public class GameRepoInMemory implements GameRepo {
	
	private Logger LOG = LoggerFactory.getLogger(GameRepoInMemory.class);
	
	private Map<UUID, Game> games = new ConcurrentHashMap<>();
	
	@Override
	public void save(Game game) {
		games.put(game.getGameId(), game);
	}
	
	@Override
	public void delete(Game game) {
		games.remove(game);
	}
	
	@Override
	public Game get(UUID gameId) {
		return games.get(gameId);
	}
	
	@PostConstruct
	public void init() {
		LOG.info("GameRepoInMemory post construct");
	}
	
	@PreDestroy
	public void destroyed() {
		LOG.info("GameRepoInMemory pre destroy");
		games.clear();
	}

}
