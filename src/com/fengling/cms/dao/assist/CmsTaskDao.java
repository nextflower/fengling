package com.fengling.cms.dao.assist;

import java.util.List;

import com.fengling.common.hibernate3.Updater;
import com.fengling.common.page.Pagination;
import com.fengling.cms.entity.assist.CmsTask;

public interface CmsTaskDao {
	public Pagination getPage(Integer siteId,int pageNo, int pageSize);
	
	public List<CmsTask> getList();

	public CmsTask findById(Integer id);

	public CmsTask save(CmsTask bean);

	public CmsTask updateByUpdater(Updater<CmsTask> updater);

	public CmsTask deleteById(Integer id);
}