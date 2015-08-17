//
//  SqlHeader.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/9.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#ifndef Demo_SMFrameWork_SqlHeader_h
#define Demo_SMFrameWork_SqlHeader_h

#define sql_delete_jokes_with_id    @"DELETE tb_joke WHERE xhid=:xhid"
#define sql_set_jokes_read_with_id  @"UPDATE tb_joke SET read=true WHERE xhid=:xhid"
#define sql_search_jokes            @"SELECT * FROM tb_joke ORDER BY xhid DESC"
#define sql_search_jokes_isRead     @"SELECT * FROM tb_joke WHERE isRead=:isRead ORDER BY xhid DESC"
#define sql_search_jokes_with_id    @"SELECT * FROM tb_joke WHERE xhid=:xhid"
#define sql_search_jokes_max_id     @"SELECT MAX(xhid) as xhid FROM tb_joke"
#define sql_search_jokes_min_id     @"SELECT MIN(xhid) as xhid FROM tb_joke"

#endif
