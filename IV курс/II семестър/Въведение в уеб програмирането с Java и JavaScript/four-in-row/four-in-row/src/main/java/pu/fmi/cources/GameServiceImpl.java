package pu.fmi.cources;

import java.util.UUID;

import org.springframework.stereotype.Component;

@Component
public class GameServiceImpl implements GameService {

	private GameRepo gameRepo;
	
	public GameServiceImpl(GameRepo gameRepo) {
		this.gameRepo = gameRepo;
	}
	
	@Override
	public Game startNewGame() {
		Game game = new Game();
		gameRepo.save(game);
		return game;
	}

	@Override
	public void makeMove(Move move) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Game getGame(UUID gameId) {
		// TODO Auto-generated method stub
		return null;
	}
}
