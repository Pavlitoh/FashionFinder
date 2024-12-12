import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart'; // Asegúrate de importar esto si estás usando go_router.
import 'package:proyectofinal/domain/providers/branch_provider.dart';

class MapView extends StatefulWidget {
  final String categoryId;

  const MapView({super.key, required this.categoryId});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMarkers();
    });
  }

  Future<void> _loadMarkers() async {
    final branchProvider = Provider.of<BranchProvider>(context, listen: false);
    await branchProvider.getBranches();

    setState(() {
      _markers.clear();
      // Filtrar los markers según el categoryId
      for (var branch in branchProvider.branches) {
        if (branch.categoryId == widget.categoryId) {
          _markers.add(
            Marker(
              markerId: MarkerId(branch.id),
              position: LatLng(branch.latitude, branch.longitude),
              infoWindow: InfoWindow(
                title: branch.name,
                snippet: branch.address,
              ),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(21.126724, -101.685444),
              zoom: 13,
            ),
            markers: _markers,
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            child: FloatingActionButton(
              heroTag: "backButton", 
              onPressed: () {
                context.go('/');
              },
              backgroundColor: Colors.white,
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
