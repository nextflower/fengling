package com.fengling.cms.manager.assist.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fengling.cms.dao.assist.CmsSiteAccessPagesDao;
import com.fengling.cms.entity.assist.CmsSiteAccessPages;
import com.fengling.cms.manager.assist.CmsSiteAccessPagesMng;
import com.fengling.common.hibernate3.Updater;
import com.fengling.common.page.Pagination;

/**
 * @author Tom
 */
@Service
@Transactional
public class CmsSiteAccessPagesMngImpl implements CmsSiteAccessPagesMng {

	public CmsSiteAccessPages findAccessPage(String sessionId, Integer pageIndex) {
		return dao.findAccessPage(sessionId,pageIndex);
	}
	
	public Pagination findPages(Integer siteId,Integer orderBy,Integer pageNo,Integer pageSize){
		return dao.findPages(siteId, orderBy,pageNo,pageSize);
	}

	public void clearByDate(Date date) {
		 dao.clearByDate(date);
	}
	
	public CmsSiteAccessPages save(CmsSiteAccessPages access) {
		return dao.save(access);
	}
	
	public CmsSiteAccessPages update(CmsSiteAccessPages access){
		Updater<CmsSiteAccessPages> updater = new Updater<CmsSiteAccessPages>(access);
		access = dao.updateByUpdater(updater);
		return access;
	}
	
	@Autowired
	private CmsSiteAccessPagesDao dao;

}
