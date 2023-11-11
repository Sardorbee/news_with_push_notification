part of 'subscription_cubit.dart';

class SubscriptionCheck extends Equatable {
   bool newsTopic;
  bool technologyTopic;
  bool medicineTopic;
  bool carsTopic;

  SubscriptionCheck({
    this.newsTopic = false,
    this.technologyTopic = false,
    this.medicineTopic = false,
    this.carsTopic = false,
  });

  SubscriptionCheck copyWith({
    bool? newsTopic,
    bool? technologyTopic,
    bool? medicineTopic,
    bool? carsTopic,
  }) {
    return SubscriptionCheck(
      newsTopic: newsTopic ?? this.newsTopic,
      technologyTopic: technologyTopic ?? this.technologyTopic,
      medicineTopic: medicineTopic ?? this.medicineTopic,
      carsTopic: carsTopic ?? this.carsTopic,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [newsTopic, technologyTopic, medicineTopic, carsTopic];
}
