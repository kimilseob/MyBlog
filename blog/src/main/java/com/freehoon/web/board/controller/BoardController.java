package com.freehoon.web.board.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.freehoon.common.Search;
import com.freehoon.web.board.model.BoardVO;
import com.freehoon.web.board.model.ReplyVO;
import com.freehoon.web.board.service.BoardService;


@Controller
//@RequestMapping(value = "/myblog2")
public class BoardController {

	@Inject
	private BoardService boardService;

	@RequestMapping(value = "/getBoardList", method = RequestMethod.GET)
	public String getBoardList(Model model , @RequestParam(required = false , defaultValue = "1") int page ,
								@RequestParam(required = false , defaultValue = "1") int range
								, @RequestParam(required = false, defaultValue = "title") String searchType
								, @RequestParam(required = false) String keyword
								) throws Exception {
		
		
		Search search = new Search();
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		//전체 게시글  개수
		int listCnt = boardService.getBoardListCnt(search);
		search.pageInfo(page, range, listCnt);

		//pagination 객체 생성
		//Pagination pagination = new Pagination();
		//pagination.pageInfo(page,range,listCnt);
		
		model.addAttribute("pagination" , search);
		model.addAttribute("boardList", boardService.getBoardList(search));
		
		return "myblog2/index";
	}

	@RequestMapping("/write")
	public String boardForm(@ModelAttribute("boardVO") BoardVO vo , Model model) {
		return "myblog2/write";
	}

	@RequestMapping(value = "/saveBoard", method = RequestMethod.POST)

	public String saveBoard(@ModelAttribute("BoardVO") BoardVO boardVO,@RequestParam("mode") String mode, RedirectAttributes rttr) throws Exception {
		
		if(mode.equals("edit")){
				boardService.updateBoard(boardVO);
		}else {
				boardService.insertBoard(boardVO);
		}
		return "redirect:/getBoardList";
	}

	@RequestMapping(value = "/content", method = RequestMethod.GET)
	public String getBoardContent(Model model, @RequestParam("bid") int bid) throws Exception {

		model.addAttribute("boardContent", boardService.getBoardContent(bid));
		model.addAttribute("replyVO" , new ReplyVO());
		return "myblog2/content";

	}

	@RequestMapping(value = "/editForm", method = RequestMethod.GET)
	public String editForm(@RequestParam("bid") int bid
			, @RequestParam("mode") String mode, Model model) throws Exception {

		model.addAttribute("boardContent", boardService.getBoardContent(bid));
		model.addAttribute("mode", mode);
		model.addAttribute("boardVO", new BoardVO());

		return "myblog2/write";

	}

	@RequestMapping(value = "/deleteBoard", method = RequestMethod.GET)
	public String deleteBoard(RedirectAttributes rttr, @RequestParam("bid") int bid) throws Exception {

		boardService.deleteBoard(bid);
		return "redirect:/getBoardList";
	}

	

	@ExceptionHandler(RuntimeException.class)

	public String exceptionHandler(Model model, Exception e){

	//logger.info("exception : " + e.getMessage());

	model.addAttribute("exception", e);

	return "error/exception";

	}



}