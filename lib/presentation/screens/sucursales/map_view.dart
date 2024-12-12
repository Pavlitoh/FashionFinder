import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
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
    return SafeArea(
      child: Scaffold(
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
              child: GestureDetector(
                onTap: () {
                  context.go('/home'); // Regresar al Home
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat, // Mueve el botón a la izquierda
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.go('/shops', extra: widget.categoryId);
          },
          child: const Icon(Icons.list),
          tooltip: "Ver Tiendas Filtradas",
        ),
      ),
    );
  }
}
