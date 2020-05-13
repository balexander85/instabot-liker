from os import environ

from instapy import InstaPy, smart_run

user_name = environ.get("insta_username")
password = environ.get("insta_password")
user_names = environ.get("insta_following").split(",")
amount_of_likes = (
    int(environ.get("amount_of_likes")) if environ.get("amount_of_likes") else 10
)
geckodriver_path = environ.get("geckodriver_path")

insta_bot = InstaPy(
    username=user_name,
    password=password,
    geckodriver_path=geckodriver_path,
    headless_browser=True,
)


if __name__ == "__main__":
    with smart_run(insta_bot):
        insta_bot.like_by_users(usernames=user_names, amount=amount_of_likes)
        insta_bot.end()
