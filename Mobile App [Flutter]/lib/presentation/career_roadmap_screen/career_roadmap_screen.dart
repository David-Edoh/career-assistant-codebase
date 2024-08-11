import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:fotisia/data/models/HomePage/subject_suggestion_resp.dart' as SS;
import 'package:fotisia/presentation/career_roadmap_screen/widgets/certification_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import '../../data/models/HomePage/career_suggestion_resp.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/card_detail.dart';
import '../../widgets/footprint_icon.dart';
import '../../widgets/image_card.dart';
import 'bloc/career_roadmap_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:carousel_slider/carousel_slider.dart';
import './start_streak_dialog_popup/start_streak_popup_dialog.dart';

class CareerRoadmapScreen extends StatelessWidget {
  const CareerRoadmapScreen({key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<CareerRoadmapBloc>(
        create: (context) => CareerRoadmapBloc(CareerRoadmapState())
          ..add(CareerRoadmapInitialEvent()),
        child: const CareerRoadmapScreen());
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    CareerToChooseFrom career = arguments['career'];

    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<CareerRoadmapBloc, CareerRoadmapState>(
        builder: (context, state) {
      return Scaffold(
          backgroundColor: appTheme.whiteA70001,
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
              height: getVerticalSize(70),
              leadingWidth: getHorizontalSize(50),
              leading: Semantics(
                label: "Image: Go back to homepage",
                child: AppbarImage(
                    svgPath: ImageConstant.imgGroup162799,
                    margin: getMargin(left: 24, top: 13, bottom: 14),
                    onTap: () {
                      onTapArrowbackone(context);
                    }
                    ),
              ),
              centerTitle: true,
              title: AppbarTitle(text: "${career.career.capitalizeFirstLetter()} Roadmap")
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              state.isStreakLoading!
                  ? FloatingActionButton.extended(
                      onPressed: () {},
                      foregroundColor: Colors.white,
                      backgroundColor: theme.colorScheme.primary,
                      label: Container(),
                      icon: Semantics(
                        label: "loading...",
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: LoadingAnimationWidget.beat(
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              !state.isStreakLoading! &&
                      state.streak != null &&
                      state.streak?.careerId == career.id
                  ? FloatingActionButton.extended(
                      onPressed: () {
                        NavigatorService.pushNamed(AppRoutes.streakInfoScreen,
                            arguments: {"streakId": state.streak!.id});
                      },
                      foregroundColor: Colors.white,
                      backgroundColor: theme.colorScheme.primary,
                      label: const Text("Continue Streak"),
                      icon: const Icon(Icons.add),
                    )
                  : Container(),
              !state.isStreakLoading! &&
                      (state.streak == null ||
                          state.streak?.careerId != career.id)
                  ? FloatingActionButton.extended(
                      onPressed: () {
                        onTapStartStreak(context, career);
                      },
                      foregroundColor: Colors.white,
                      backgroundColor: theme.colorScheme.primary,
                      // shape: const CircleBorder(),
                      label: const Text("Start Learning Streak"),
                      icon: const Icon(Icons.add),
                    )
                  : Container(),
            ],
          ),
          body: SafeArea(
            child: ListView(
              children: getSubjectsInLevels(career.roadmap.careerSubjects,
                      career.roadmap.suggestedcertifications, career.roadmap.suggestedprojects)
                  .map((level) => RoadmapLevel(
                        subjects: level["subjects"],
                        certifications: level["certifications"],
                        projects: level["projects"],
                      ))
                  .toList(),
            ),
          ));
    });
  }

  onTapImgImage(BuildContext context) {
    NavigatorService.goBack();
  }

  onTapContinue(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.jobTypeScreen,
    );
  }

  onTapArrowbackone(BuildContext context) {
    Navigator.pop(context);
  }
}

const String _errorImage =
    "https://i.ytimg.com/vi/z8wrRRR7_qU/maxresdefault.jpg";

class SubjectsWidget extends StatelessWidget {
  final String description;
  final String subject;
  final String learningDuration;
  final List<Course> courses;

  SubjectsWidget({
    required this.description,
    required this.subject,
    required this.courses,
    required this.learningDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: DotSection(),
          ),
          Text(subject,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(learningDuration.isNotEmpty) Text("Learning Duration: $learningDuration streak."),
              Text(learningDuration.isNotEmpty ?  "(Pick and complete only one course from this section)" : "(Soft-skills)",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "Description:",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          Text('$description',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
          SizedBox(height: 8),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              viewportFraction: 0.7,
              initialPage: 0,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              padEnds: false,
              enlargeFactor: 0.3,
              // clipBehavior: Clip.none,
            ),
            items: courses.map((course) {
              return _getUrlValid(
                      course.CourseInfo.link.toString().fixWhiteSpaceInUrl())
                  ? CourseTile(course: course)
                  : Text(course.CourseInfo.link.toString());
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class RoadmapLevel extends StatelessWidget {
  final List<SS.SuggestedSubject> subjects;
  final List<SuggestedCertification> certifications;
  final List<SuggestedProject> projects;

  const RoadmapLevel({
    super.key,
    required this.subjects,
    required this.certifications,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // padding: EdgeInsets.all(16.0),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(subjects.isNotEmpty) Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
              removeNumbersSuffix(subjects[0].level.toString()).capitalizeFirstLetter(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
              )
          ),
        ),

        if(subjects.isNotEmpty) Column(
          children: subjects.map((subject) => SubjectsWidget(
                    description: subject.description.toString(),
                    subject: subject.subject.toString().capitalizeFirstLetter(),
                    learningDuration: subject.learningDuration!,
                    courses: subject.careerContents!.map((careerContent) => Course(CourseInfo: careerContent)).toList(),
                  )).toList(),
        ),

        if(certifications.isNotEmpty) CertificationsRow(
          description: 'A list of certifications that are valuable for your career at this level. Take any of your choice.',
          subject: 'Certifications',
          certifications: certifications,
        ),

        if(projects.isNotEmpty) Padding(
          padding: const EdgeInsets.fromLTRB(35,0,8.0,0),
          child: DotSection(),
        ),

        if(projects.isNotEmpty) const Padding(
          padding: EdgeInsets.fromLTRB(25,0,8.0,0),
          child: Text("Projects Ideas", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),

        if(projects.isNotEmpty) Padding(
          padding: const EdgeInsets.fromLTRB(10,0,8.0,0),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 410.0,
              viewportFraction: 0.7,
              initialPage: 0,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              padEnds: false,
              enlargeFactor: 0.3,
            ),
            items: projects.map((proj) {
              return DetailCard(imageUrl: "https://images.unsplash.com/photo-1572177812156-58036aae439c?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", heading: proj.name, description: proj.solutionIdea,);
            }).toList(),
          ),
        ),
        const SizedBox(height: 40)
      ],
    );
  }
}

class CourseTile extends StatelessWidget {
  final Course course;

  CourseTile({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            foregroundDecoration: RotatedCornerDecoration.withColor(
              color: course.CourseInfo?.price != null
                  ? course.CourseInfo.price! > 0
                      ? Colors.blue
                      : Colors.green
                  : Colors.blue,
              spanBaselineShift: 4,
              badgeSize: Size(64, 64),
              badgeCornerRadius: Radius.circular(8),
              badgePosition: BadgePosition.topStart,
              textSpan: TextSpan(
                text:
                    '${course.CourseInfo?.price != null ? course.CourseInfo.price! > 0 ? "Paid" : "free" : ""}\nCourse',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    BoxShadow(color: Colors.yellowAccent, blurRadius: 8),
                  ],
                ),
              ),
            ),
            // height: 50.0,
            width: MediaQuery.of(context).size.width * 0.85,
            height: mediaQueryData.size.height * 0.35,
            child: course.CourseInfo.platform != "Edx" ? AnyLinkPreview(
              displayDirection: UIDirection.uiDirectionVertical,
              link: course.CourseInfo.link
                  .toString()
                  .fixWhiteSpaceInUrl()
                  .removeWwwFromUrl(),
              backgroundColor: Colors.white,
              errorBody: course.CourseInfo.description,
              errorTitle: course.CourseInfo.title,
              errorWidget: ImageCard(
                imageUrl: course.CourseInfo.imageUrl ?? "https://cdn.elearningindustry.com/wp-content/uploads/2020/02/soft-skills-training-for-employees.png",
                url: course.CourseInfo.link!.fixWhiteSpaceInUrl().removeWwwFromUrl(),
                description: course.CourseInfo.title!,
              ),
              errorImage: course.CourseInfo.imageUrl,
            ) : ImageCard(
              imageUrl: course.CourseInfo.imageUrl ?? "https://blogassets.leverageedu.com/blog/wp-content/uploads/2020/05/23151218/BA-Courses.png",
              url: course.CourseInfo.link!.fixWhiteSpaceInUrl().removeWwwFromUrl(),
              description: course.CourseInfo.title!,
            ),
          ),
          course.CourseInfo.platform != null ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text(
                        course.CourseInfo.platform.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ) : Container()
        ],
      ),
    );
  }
}

class Course {
  SS.CareerContent CourseInfo;

  Course({
    required this.CourseInfo,
  });
}

List<Map<String, dynamic>> getSubjectsInLevels(
    List<SS.SuggestedSubject> subjects,
    List<SuggestedCertification> certifications,
    List<SuggestedProject> projects) {
  List<SS.SuggestedSubject> beginnerSubjects = [];
  List<SS.SuggestedSubject> intermediateSubjects = [];
  List<SS.SuggestedSubject> advancedSubjects = [];
  for (var i = 0; i < subjects.length; i++) {
    if (subjects[i].level!.contains("beginner")) {
      beginnerSubjects.add(subjects[i]);
    }

    if (subjects[i].level!.contains("intermediate")) {
      intermediateSubjects.add(subjects[i]);
    }

    if (subjects[i].level!.contains("advance")) {
      advancedSubjects.add(subjects[i]);
    }
  }

  List<SuggestedCertification> beginnerCertifications = [];
  List<SuggestedCertification> intermediateCertifications = [];
  List<SuggestedCertification> advancedCertifications = [];
  for (var i = 0; i < certifications.length; i++) {
    if (certifications[i].level!.contains("beginner")) {
      beginnerCertifications.add(certifications[i]);
    }

    if (certifications[i].level!.contains("intermediate")) {
      intermediateCertifications.add(certifications[i]);
    }

    if (certifications[i].level!.contains("advance")) {
      advancedCertifications.add(certifications[i]);
    }
  }

  List<SuggestedProject> beginnerProjects = [];
  List<SuggestedProject> intermediateProjects = [];
  List<SuggestedProject> advancedProjects = [];
  for (var i = 0; i < projects.length; i++) {
    if (projects[i].level!.contains("beginner")) {
      beginnerProjects.add(projects[i]);
    }

    if (projects[i].level!.contains("intermediate")) {
      intermediateProjects.add(projects[i]);
    }

    if (projects[i].level!.contains("advance")) {
      advancedProjects.add(projects[i]);
    }
  }

  return [
    {
      "subjects": beginnerSubjects,
      "certifications": beginnerCertifications,
      "projects": beginnerProjects
    },
    {
      "subjects": intermediateSubjects,
      "certifications": intermediateCertifications,
      "projects": intermediateProjects
    },
    {
      "subjects": advancedSubjects,
      "certifications": advancedCertifications,
      "projects": advancedProjects
    },
  ];
}


// CertificateCard widget
class CertificateCard extends StatelessWidget {
  final SuggestedCertification certificate;

  CertificateCard({super.key, required this.certificate});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(certificate.certificationName),
        subtitle: Text(certificate.level),
        trailing: IconButton(
          icon: Icon(Icons.link),
          onPressed: () => _launchURL(certificate.url),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}

// ProjectCard widget
class ProjectCard extends StatelessWidget {
  final SuggestedProject project;

  ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: GridTile(
            header: Container(
              padding: const EdgeInsets.only(top: 3),
              height: 30,
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.6)),
              child: Text(
                project.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey[100], fontWeight: FontWeight.bold),
              ),
            ),
          footer: Container(
            padding: const EdgeInsets.only(top: 3),
            height: 30,
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.6)),
            child: Column(
              children: [
                const Text(
                  "Problem Statement",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                Text(
                  project.problem,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Solution",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                Text(
                  project.solutionIdea,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
            child: Image.network( "https://images.unsplash.com/photo-1529220813929-597ff9755c1f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1351&q=80", fit: BoxFit.cover),
        )
    );
  }
}



bool _getUrlValid(String url) {
  bool _isUrlValid =
      AnyLinkPreview.isValidLink(url, protocols: ['http', 'https']);
  return _isUrlValid;
}

onTapStartStreak(BuildContext context, CareerToChooseFrom career) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            content: StartStreakPopupDialog(career: career).builder(context),
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.only(left: 0),
          )
  ).then((value){
    context.read<CareerRoadmapBloc>().add(CareerRoadmapInitialEvent());
  });
}
