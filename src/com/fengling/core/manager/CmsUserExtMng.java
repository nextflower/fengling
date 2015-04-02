package com.fengling.core.manager;

import com.fengling.core.entity.CmsUser;
import com.fengling.core.entity.CmsUserExt;

public interface CmsUserExtMng {
	public CmsUserExt save(CmsUserExt ext, CmsUser user);

	public CmsUserExt update(CmsUserExt ext, CmsUser user);
}