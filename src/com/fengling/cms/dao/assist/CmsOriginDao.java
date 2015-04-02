package com.fengling.cms.dao.assist;

import java.util.List;

import com.fengling.common.hibernate3.Updater;
import com.fengling.common.page.Pagination;
import com.fengling.cms.entity.assist.CmsOrigin;

public interface CmsOriginDao {
	public Pagination getPage(int pageNo, int pageSize);

	public List<CmsOrigin> getList(String name);

	public CmsOrigin findById(Integer id);

	public CmsOrigin save(CmsOrigin bean);

	public CmsOrigin updateByUpdater(Updater<CmsOrigin> updater);

	public CmsOrigin deleteById(Integer id);
}