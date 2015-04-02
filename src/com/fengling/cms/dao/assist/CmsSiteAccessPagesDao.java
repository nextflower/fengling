package com.fengling.cms.dao.assist;

import java.util.Date;

import com.fengling.cms.entity.assist.CmsSiteAccessPages;
import com.fengling.common.hibernate3.Updater;
import com.fengling.common.page.Pagination;

/**
 * @author Tom
 */
public interface CmsSiteAccessPagesDao {

	public CmsSiteAccessPages findAccessPage(String sessionId, Integer pageIndex);
	
	public Pagination findPages(Integer siteId,Integer orderBy,Integer pageNo,Integer pageSize);

	public CmsSiteAccessPages save(CmsSiteAccessPages access);

	public CmsSiteAccessPages updateByUpdater(Updater<CmsSiteAccessPages> updater);

	public void clearByDate(Date date);

}
