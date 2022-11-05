class SchoolModel {
  int? code;
  List<Article>? data;

  SchoolModel({this.code, this.data});

  SchoolModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <Article>[];
      json['data'].forEach((v) {
        data!.add(Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Article {
  String? articleTitle;
  String? articleBody;
  String? articleUrl;
  String? createdAt;

  Article(
      {this.articleTitle, this.articleBody, this.articleUrl, this.createdAt});

  Article.fromJson(Map<String, dynamic> json) {
    articleTitle = json['article_title'];
    articleBody = json['article_body'];
    articleUrl = json['article_url'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['article_title'] = this.articleTitle;
    data['article_body'] = this.articleBody;
    data['article_url'] = this.articleUrl;
    data['created_at'] = this.createdAt;
    return data;
  }

  @override
  String toString() {
    return 'Article{articleTitle: $articleTitle, articleBody: $articleBody, articleUrl: $articleUrl, createdAt: $createdAt}';
  }
}
