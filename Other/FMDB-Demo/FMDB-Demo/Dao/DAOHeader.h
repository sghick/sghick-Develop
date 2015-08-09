//
//  DAOHeader.h
//  FMDB-Demo
//
//  Created by 丁治文 on 15/8/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#ifndef FMDB_Demo_DAOHeader_h
#define FMDB_Demo_DAOHeader_h


#define sql_insert_user             @"INSERT INTO SGKUser (name,age) VALUES(:name,:age)"
#define sql_delete_user             @"DELETE FROM SGKUser"
#define sql_delete_user_with_uid    @"DELETE FROM SGKUser WHERE uid = %@"
//#define sql_update_user             @"UPDATE SGKUser SET name=:name,age=:age WHERE uid=:uid"
#define sql_update_user             @"UPDATE SGKUser SET uid=:uid,name=:name,age=:age WHERE uid=:uid"
#define sql_search_user             @"SELECT * from SGKUser"
#define sql_search_user_with_uid    @"SELECT * FROM SGKUser WHERE uid = %@"

#endif
