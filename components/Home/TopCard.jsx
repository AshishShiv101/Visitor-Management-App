import { View, Text, TouchableOpacity, StyleSheet, FlatList, Dimensions, Animated } from 'react-native';
import React, { useRef, useState } from 'react';
import Colors from '../../constant/Colors';
import { LinearGradient } from "expo-linear-gradient";
import { FontAwesome } from "@expo/vector-icons";

const { width } = Dimensions.get('window');
const CARD_WIDTH = width * 0.9;
const SPACING = width * 0.05;

export default function CardCarousel() {
    const [activeIndex, setActiveIndex] = useState(0);
    const flatListRef = useRef(null);

    // Sample data - replace with your actual data
    const cardsData = [
        { id: '1', name: 'Ranbir Kapoor', message: 'lorem50', time: '10:30 AM' },
        { id: '2', name: 'John Doe', message: 'Another message', time: '11:45 AM' },
        { id: '3', name: 'Jane Smith', message: 'Third message', time: '2:15 PM' },
    ];

    const renderCard = ({ item }) => (
        <LinearGradient
            colors={[Colors.PRIMARY, Colors.BUTTON]}
            start={{ x: 0, y: 0 }}
            end={{ x: 1, y: 1 }}
            style={styles.card}
        >
            <View style={styles.patternOverlay} />
            <View style={styles.contentContainer}>
                <View style={styles.mainContent}>
                    <View style={styles.header}>
                        <Text style={styles.visitorName}>{item.name}</Text>
                        <Text style={styles.message}>{item.message}</Text>
                        <Text style={styles.time}>{item.time}</Text>
                    </View>
                </View>

                <View style={styles.buttonsContainer}>
                    <TouchableOpacity style={[styles.button, styles.acceptButton]}>
                        <FontAwesome name="check" size={18} color="#fff" />
                        <Text style={styles.buttonText}>Accept</Text>
                    </TouchableOpacity>

                    <TouchableOpacity style={[styles.button, styles.rejectButton]}>
                        <FontAwesome name="times" size={18} color="#fff" />
                        <Text style={styles.buttonText}>Reject</Text>
                    </TouchableOpacity>

                    <TouchableOpacity style={[styles.button, styles.stallButton]}>
                        <FontAwesome name="clock-o" size={18} color="#fff" />
                        <Text style={styles.buttonText}>Stall</Text>
                    </TouchableOpacity>
                </View>
            </View>
        </LinearGradient>
    );

    const renderPaginationDots = () => {
        return (
            <View style={styles.paginationContainer}>
                {cardsData.map((_, index) => (
                    <View
                        key={index}
                        style={[
                            styles.paginationDot,
                            index === activeIndex && styles.paginationDotActive,
                        ]}
                    />
                ))}
            </View>
        );
    };

    const onViewableItemsChanged = useRef(({ viewableItems }) => {
        if (viewableItems[0] != null) {
            setActiveIndex(viewableItems[0].index);
        }
    }).current;

    return (
        <View style={styles.container}>
            <FlatList
                ref={flatListRef}
                data={cardsData}
                renderItem={renderCard}
                keyExtractor={(item) => item.id}
                horizontal
                pagingEnabled
                showsHorizontalScrollIndicator={false}
                snapToInterval={CARD_WIDTH + SPACING}
                decelerationRate="fast"
                viewabilityConfig={{
                    viewAreaCoveragePercentThreshold: 50,
                }}
                onViewableItemsChanged={onViewableItemsChanged}
                contentContainerStyle={styles.flatListContent}
            />
            {renderPaginationDots()}
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    flatListContent: {
        paddingHorizontal: SPACING / 2,
    },
    card: {
        borderRadius: 15,
        marginVertical: 20,
        shadowColor: '#000',
        shadowOpacity: 0.2,
        shadowRadius: 8,
        shadowOffset: { width: 0, height: 4 },
        width: CARD_WIDTH,
        marginHorizontal: SPACING / 2,
        alignSelf: 'center',
        overflow: 'hidden',
    },
    patternOverlay: {
        position: "absolute",
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        opacity: 0.15,
        backgroundColor: "#fff",
        borderRadius: 150,
        width: "100%",
        height: "100%",
        transform: [{ rotate: "45deg" }],
    },
    contentContainer: {
        zIndex: 1,
        flexDirection: 'row',
    },
    mainContent: {
        flex: 1,
        padding: 20,
        paddingRight: 15,
    },
    header: {
        alignItems: 'flex-start',
    },
    visitorName: {
        fontSize: 24,
        fontWeight: 'bold',
        color: '#2e2e2e',
        marginBottom: 8,
        textShadowColor: 'rgba(0, 0, 0, 0.2)',
        textShadowOffset: { width: 1, height: 1 },
        textShadowRadius: 2,
    },
    message: {
        fontSize: 16,
        color: '#2e2e2e',
        marginBottom: 6,
    },
    time: {
        fontSize: 14,
        color: '#2e2e2e',
        fontWeight: '500',
    },
    buttonsContainer: {
        alignItems: 'flex-end',
        justifyContent: 'center',
        gap: 8,
        marginRight: -1,
        paddingVertical: 10,
    },
    button: {
        width: 90,
        paddingVertical: 10,
        paddingHorizontal: 15,
        borderTopLeftRadius: 20,
        borderBottomLeftRadius: 20,
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'flex-start',
        gap: 8,
        elevation: 3,
        shadowColor: '#000',
        shadowOpacity: 0.25,
        shadowRadius: 4,
        shadowOffset: { width: -2, height: 2 },
    },
    acceptButton: {
        backgroundColor: '#34C759',
    },
    rejectButton: {
        backgroundColor: '#FF3B30',
    },
    stallButton: {
        backgroundColor: '#8E8E93',
    },
    buttonText: {
        color: '#fff',
        fontWeight: 'bold',
        fontSize: 14,
    },
    paginationContainer: {
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center',
        marginTop: -10,
        marginBottom: 20,
    },
    paginationDot: {
        width: 8,
        height: 8,
        borderRadius: 4,
        backgroundColor: '#ccc',
        marginHorizontal: 4,
    },
    paginationDotActive: {
        backgroundColor: Colors.BUTTON,
        width: 12,
        height: 12,
        borderRadius: 6,
    },
});