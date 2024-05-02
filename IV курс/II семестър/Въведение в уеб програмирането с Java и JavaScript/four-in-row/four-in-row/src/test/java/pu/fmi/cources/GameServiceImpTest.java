package pu.fmi.cources;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;

public class GameServiceImpTest {
	
	@Test
	void testStartNewGame() {
		var gameRepo = new GameRepoInMemory();
		var gameServiceImpl = new GameServiceImpl(gameRepo);
		var game = gameService.startNewGame();
		
		assertNotNull(game);
		assertNotNull(game.getGameId());
		var storedGame = gameRepo.get(game.getGameId());
		assertEquals(game.getGameId(), storedGame.getGameId());

	}
}
