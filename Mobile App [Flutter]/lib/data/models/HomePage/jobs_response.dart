class JobResponse {
  final String message;
  final List<Job> jobs;

  JobResponse({required this.message, required this.jobs});

  factory JobResponse.fromJson(Map<String, dynamic> json) {
    var jobsList = json['jobs'] as List;
    List<Job> jobs = jobsList.map((job) => Job.fromJson(job)).toList();

    return JobResponse(
      message: json['message'],
      jobs: jobs,
    );
  }
}

class Job {
  final String kind;
  final String title;
  final String htmlTitle;
  final String link;
  final String displayLink;
  final String snippet;
  final String htmlSnippet;
  final String formattedUrl;
  final String htmlFormattedUrl;
  // final Pagemap pagemap;

  Job({
    required this.kind,
    required this.title,
    required this.htmlTitle,
    required this.link,
    required this.displayLink,
    required this.snippet,
    required this.htmlSnippet,
    required this.formattedUrl,
    required this.htmlFormattedUrl,
    // required this.pagemap,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      kind: json['kind'],
      title: json['title'],
      htmlTitle: json['htmlTitle'],
      link: json['link'],
      displayLink: json['displayLink'],
      snippet: json['snippet'],
      htmlSnippet: json['htmlSnippet'],
      formattedUrl: json['formattedUrl'],
      htmlFormattedUrl: json['htmlFormattedUrl'],
      // pagemap: Pagemap.fromJson(json['pagemap']),
    );
  }
}

class Pagemap {
  final List<CseThumbnail> cseThumbnail;
  final List<Metatag> metatags;
  final List<CseImage> cseImage;

  Pagemap({
    required this.cseThumbnail,
    required this.metatags,
    required this.cseImage,
  });

  factory Pagemap.fromJson(Map<String, dynamic> json) {
    var cseThumbnailList = json['cse_thumbnail'] as List;
    List<CseThumbnail> cseThumbnail = cseThumbnailList.map((item) => CseThumbnail.fromJson(item)).toList();

    var metatagsList = json['metatags'] as List;
    List<Metatag> metatags = metatagsList.map((item) => Metatag.fromJson(item)).toList();

    var cseImageList = json['cse_image'] as List;
    List<CseImage> cseImage = cseImageList.map((item) => CseImage.fromJson(item)).toList();

    return Pagemap(
      cseThumbnail: cseThumbnail,
      metatags: metatags,
      cseImage: cseImage,
    );
  }
}

class CseThumbnail {
  final String src;
  final String width;
  final String height;

  CseThumbnail({
    required this.src,
    required this.width,
    required this.height,
  });

  factory CseThumbnail.fromJson(Map<String, dynamic> json) {
    return CseThumbnail(
      src: json['src'],
      width: json['width'],
      height: json['height'],
    );
  }
}

class Metatag {
  final String ogImage;
  final String themeColor;
  final String twitterCard;
  final String clientsideingraphs;
  final String industryids;
  final String alAndroidPackage;
  final String locale;
  final String alIosUrl;
  final String ogDescription;
  final String alIosAppStoreId;
  final String twitterImage;
  final String companyid;
  final String twitterSite;
  final String litmsprofilename;
  final String ogType;
  final String twitterTitle;
  final String alIosAppName;
  final String ogTitle;
  final String titleid;
  final String pagekey;
  final String alAndroidUrl;
  final String lnkdUrl;
  final String viewport;
  final String twitterDescription;
  final String ogUrl;
  final String alAndroidAppName;

  Metatag({
    required this.ogImage,
    required this.themeColor,
    required this.twitterCard,
    required this.clientsideingraphs,
    required this.industryids,
    required this.alAndroidPackage,
    required this.locale,
    required this.alIosUrl,
    required this.ogDescription,
    required this.alIosAppStoreId,
    required this.twitterImage,
    required this.companyid,
    required this.twitterSite,
    required this.litmsprofilename,
    required this.ogType,
    required this.twitterTitle,
    required this.alIosAppName,
    required this.ogTitle,
    required this.titleid,
    required this.pagekey,
    required this.alAndroidUrl,
    required this.lnkdUrl,
    required this.viewport,
    required this.twitterDescription,
    required this.ogUrl,
    required this.alAndroidAppName,
  });

  factory Metatag.fromJson(Map<String, dynamic> json) {
    return Metatag(
      ogImage: json['og:image'],
      themeColor: json['theme-color'],
      twitterCard: json['twitter:card'],
      clientsideingraphs: json['clientsideingraphs'],
      industryids: json['industryids'],
      alAndroidPackage: json['al:android:package'],
      locale: json['locale'],
      alIosUrl: json['al:ios:url'],
      ogDescription: json['og:description'],
      alIosAppStoreId: json['al:ios:app_store_id'],
      twitterImage: json['twitter:image'],
      companyid: json['companyid'],
      twitterSite: json['twitter:site'],
      litmsprofilename: json['litmsprofilename'],
      ogType: json['og:type'],
      twitterTitle: json['twitter:title'],
      alIosAppName: json['al:ios:app_name'],
      ogTitle: json['og:title'],
      titleid: json['titleid'],
      pagekey: json['pagekey'],
      alAndroidUrl: json['al:android:url'],
      lnkdUrl: json['lnkd:url'],
      viewport: json['viewport'],
      twitterDescription: json['twitter:description'],
      ogUrl: json['og:url'],
      alAndroidAppName: json['al:android:app_name'],
    );
  }
}

class CseImage {
  final String src;

  CseImage({required this.src});

  factory CseImage.fromJson(Map<String, dynamic> json) {
    return CseImage(src: json['src']);
  }
}
