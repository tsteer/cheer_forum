user_1 = User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01')
forum_category_1 = ForumCategory.create(title: 'Test category title')
ForumThread.create(title: 'Forum thread title', forum_category: forum_category_1, user: user_1)
