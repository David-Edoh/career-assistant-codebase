import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:just_audio/just_audio.dart';

class MyCustomSource extends StreamAudioSource {
  final List<Uint8List> _chunks = [];
  bool _isClosed = false;

  void addChunk(Uint8List chunk) {
    _chunks.add(chunk);
    // notifyListeners();
  }

  void close() {
    _isClosed = true;
    // notifyListeners();
  }

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    if (_chunks.isEmpty && !_isClosed) {
      // Wait until chunks are available
      await Future.delayed(Duration(milliseconds: 100));
    }

    if (_chunks.isNotEmpty) {
      final chunk = _chunks.removeAt(0);
      return StreamAudioResponse(
        sourceLength: chunk.length,
        // rangeStart: start ?? 0,
        contentLength: chunk.length,
        stream: Stream.value(chunk), offset: 0, contentType: 'audio/mpeg',);
    } else if (_isClosed) {
      return StreamAudioResponse(
        sourceLength: 0,
        // rangeStart: 0,
        contentLength: 0,
        stream: Stream.empty(), offset: 0, contentType: 'audio/mpeg',);
    }

    return Future.error('No data available');
  }
}
