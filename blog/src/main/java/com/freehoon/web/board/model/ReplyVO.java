package com.freehoon.web.board.model;

public class ReplyVO {
	int rid;
	int bid;
	String content;
	String reg_id;
	String edit_dt;
	String reg_dt;
	public int getRid() {
		return rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
	}
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReg_id() {
		return reg_id;
	}
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	public String getEdit_dt() {
		return edit_dt;
	}
	public void setEdit_dt(String edit_dt) {
		this.edit_dt = edit_dt;
	}
	public String getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	@Override
	public String toString() {
		return "ReplyVO [rid=" + rid + ", bid=" + bid + ", content=" + content + ", reg_id=" + reg_id + ", edit_dt="
				+ edit_dt + ", reg_dt=" + reg_dt + "]";
	}
	
	
}
