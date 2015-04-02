package com.fengling.cms.dao.main;

import com.fengling.common.hibernate3.Updater;
import com.fengling.common.page.Pagination;
import com.fengling.cms.entity.main.CmsThirdAccount;

public interface CmsThirdAccountDao {
	public Pagination getPage(String username,String source,int pageNo, int pageSize);

	public CmsThirdAccount findById(Long id);
	
	public CmsThirdAccount findByKey(String key);

	public CmsThirdAccount save(CmsThirdAccount bean);

	public CmsThirdAccount updateByUpdater(Updater<CmsThirdAccount> updater);

	public CmsThirdAccount deleteById(Long id);
}