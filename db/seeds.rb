user_1 = User.create(
  username: 'Testusername',
  email: 'test@test.com',
  date_of_birth: '1990-08-01',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)

forum_category_1 = ForumCategory.create(
  title: 'Test category title 1'
)

forum_category_2 = ForumCategory.create(
  title: 'Test category title 2'
)

forum_category_3 = ForumCategory.create(
  title: 'Test category title 3'
)

ForumThread.create(
  title: 'Forum thread title 1',
  forum_category: forum_category_1,
  user: user_1
)

ForumThread.create(
  title: 'Forum thread title 2',
  forum_category: forum_category_1,
  user: user_1
)

ForumThread.create(
  title: 'Forum thread title 3',
  forum_category: forum_category_1,
  user: user_1
)

ForumThread.create(
  title: 'Forum thread title 4',
  forum_category: forum_category_2,
  user: user_1
)
ForumThread.create(
  title: 'Forum thread title 5',
  forum_category: forum_category_2,
  user: user_1
)

ForumThread.create(
  title: 'Forum thread title 6',
  forum_category: forum_category_2,
  user: user_1
)

ForumThread.create(
  title: 'Forum thread title 7',
  forum_category: forum_category_3,
  user: user_1
)

ForumThread.create(
  title: 'Forum thread title 8',
  forum_category: forum_category_3,
  user: user_1
)

ForumThread.create(
  title: 'Forum thread title 9',
  forum_category: forum_category_3,
  user: user_1
)

Article.create(
  title: 'Title 1',
  subheading: 'This is a subheading 1',
  author: 'Article author 1',
  article_text: 'Article text sdkjfhkdh kajdsflj a.kjdfksj'
)

Article.create(
  title: 'Title 2',
  subheading: 'This is a subheading 2',
  author: 'Article author 2',
  article_text: 'Article text sdkjfhkdh kajdsflj a.kjdfksj'
)

Article.create(
  title: 'Title 3',
  subheading: 'This is a subheading 3',
  author: 'Article author 3',
  article_text: 'Article text sdkjfhkdh kajdsflj a.kjdfksj'
)
