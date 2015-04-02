package com.fengling.cms.manager.main;

import com.fengling.cms.entity.main.Content;
import com.fengling.cms.entity.main.ContentExt;

public interface ContentExtMng {
	public ContentExt save(ContentExt ext, Content content);

	public ContentExt update(ContentExt ext);
}