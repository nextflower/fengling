package com.fengling.core.manager;

import com.fengling.core.entity.CmsUser;
import com.fengling.core.entity.CmsUserResume;

public interface CmsUserResumeMng {
	public CmsUserResume save(CmsUserResume ext, CmsUser user);

	public CmsUserResume update(CmsUserResume ext, CmsUser user);
}