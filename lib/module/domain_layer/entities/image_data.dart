
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

class ImageData extends Equatable {
  final Uint8List imageMemory;
  final String imageName;

  const ImageData({
    required this.imageMemory,
    required this.imageName,});

  @override
  List<Object?> get props => [imageName, imageMemory];
}