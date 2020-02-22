package com.freehoon.web.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.freehoon.common.Search;
import com.freehoon.web.board.dao.BoardDAO;
import com.freehoon.web.board.model.BoardVO;
import com.freehoon.web.board.model.ReplyVO;

@Transactional
@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO boardDAO;

	@Override
	public List<BoardVO> getBoardList(Search search) throws Exception {
		return boardDAO.getBoardList(search);
	}

	@Override
	public void insertBoard(BoardVO boardVO) throws Exception {
		boardDAO.insertBoard(boardVO);
	}

	@Override
	public BoardVO getBoardContent(int bid) throws Exception {

		/*
		 * boardDAO.updateViewCnt(bid);
		 * 
		 * return boardDAO.getBoardContent(bid);
		 */

		BoardVO boardVO = new BoardVO();

		boardDAO.updateViewCnt(bid);
		boardVO = boardDAO.getBoardContent(bid);

		// boardVO.setBid(bid);
		// boardVO.setCate_cd("1111111111111111111111111111111111111");
		// boardDAO.updateBoard(boardVO);

		return boardVO;
	}

	@Override
	public void updateBoard(BoardVO boardVO) throws Exception {
		boardDAO.updateBoard(boardVO);
	}

	@Override

	public void deleteBoard(int bid) throws Exception {
		boardDAO.deleteBoard(bid);
	}

	@Override
	public int getBoardListCnt(Search search) throws Exception {
		return boardDAO.getBoardListCnt(search);
	}

	// ´ñ±Û ¸®½ºÆ®

	@Override
	public List<ReplyVO> getReplyList(int bid) throws Exception {
		return boardDAO.getReplyList(bid);
	}
	@Override
	public int saveReply(ReplyVO replyVO) throws Exception {
		return boardDAO.saveReply(replyVO);
	}

	@Override
	public int updateReply(ReplyVO replyVO) throws Exception {
		return boardDAO.updateReply(replyVO);
	}

	@Override
	public int deleteReply(int rid) throws Exception {
		return boardDAO.deleteReply(rid);
	}

}
