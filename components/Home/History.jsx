import React, { useRef, useState } from 'react';
import { View, Text, StyleSheet, Dimensions, Animated, TouchableOpacity } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import Colors from '../../constant/Colors';
import { router, useRouter } from 'expo-router';

const { width } = Dimensions.get('window');
const CARD_WIDTH = width * 0.8;
const SPACING = 10;
const SIDE_SPACING = (width - CARD_WIDTH) / 2 - SPACING;

const visitors = [
    { name: 'John Doe', message: 'Please let me in!', time: '10:30 AM', status: 'Pending' },
    { name: 'Jane Smith', message: 'Delivery package.', time: '11:15 AM', status: 'Approved' },
    { name: 'Mike Brown', message: 'Here for a meeting.', time: '12:45 PM', status: 'Pending' },
    { name: 'Alice Green', message: 'Quick visit.', time: '1:30 PM', status: 'Declined' },
    { name: 'Tom White', message: 'Checking the meter.', time: '2:00 PM', status: 'Approved' },
];

export default function History() {
    const router = useRouter();
    const scrollX = useRef(new Animated.Value(0)).current;
    const flatListRef = useRef(null);
    const [activeIndex, setActiveIndex] = useState(0);
    const insets = useSafeAreaInsets();

    const getStatusColor = (status) => {
        switch (status) {
            case 'Approved': return '#4CAF50';
            case 'Declined': return '#F44336';
            default: return '#FFC107';
        }
    };

    const onViewableItemsChanged = useRef(({ viewableItems }) => {
        if (viewableItems.length > 0) {
            setActiveIndex(viewableItems[0].index);
        }
    }).current;

    const viewabilityConfig = useRef({
        itemVisiblePercentThreshold: 50
    }).current;

    const getItemLayout = (_, index) => ({
        length: CARD_WIDTH + SPACING * 2,
        offset: (CARD_WIDTH + SPACING * 2) * index,
        index,
    });

    return (
        <View style={[styles.container, { paddingTop: insets.top }]}>
            <Text style={styles.title}>Recent Visitors</Text>

            <Animated.FlatList
                ref={flatListRef}
                data={visitors}
                horizontal
                showsHorizontalScrollIndicator={false}
                snapToInterval={CARD_WIDTH + SPACING * 2}
                decelerationRate="fast"
                contentContainerStyle={[
                    styles.scrollContainer,
                    { paddingHorizontal: SIDE_SPACING }
                ]}
                onScroll={Animated.event(
                    [{ nativeEvent: { contentOffset: { x: scrollX } } }],
                    { useNativeDriver: true }
                )}
                scrollEventThrottle={16}
                onViewableItemsChanged={onViewableItemsChanged}
                viewabilityConfig={viewabilityConfig}
                getItemLayout={getItemLayout}
                renderItem={({ item, index }) => {
                    const inputRange = [
                        (index - 1) * (CARD_WIDTH + SPACING * 2),
                        index * (CARD_WIDTH + SPACING * 2),
                        (index + 1) * (CARD_WIDTH + SPACING * 2),
                    ];

                    const scale = scrollX.interpolate({
                        inputRange,
                        outputRange: [0.9, 1, 0.9],
                        extrapolate: 'clamp',
                    });

                    const opacity = scrollX.interpolate({
                        inputRange,
                        outputRange: [0.5, 1, 0.5],
                        extrapolate: 'clamp',
                    });

                    return (
                        <TouchableOpacity
                            activeOpacity={0.9}
                            onPress={() => console.log(`Pressed ${item.name}'s card`)}
                        >
                            <Animated.View
                                style={[
                                    styles.card,
                                    {
                                        transform: [{ scale }],
                                        opacity,
                                    }
                                ]}
                            >
                                <View style={styles.cardHeader}>
                                    <Text style={styles.visitorName}>{item.name}</Text>
                                    <View style={[styles.statusBadge, { backgroundColor: getStatusColor(item.status) }]}>
                                        <Text style={styles.statusText}>{item.status}</Text>
                                    </View>
                                </View>
                                <Text style={styles.message}>{item.message}</Text>
                                <Text style={styles.time}>{item.time}</Text>
                            </Animated.View>
                        </TouchableOpacity>
                    );
                }}
                keyExtractor={(_, index) => index.toString()}
            />

            <View style={styles.pagination}>
                {visitors.map((_, index) => (
                    <View
                        key={index}
                        style={[
                            styles.paginationDot,
                            activeIndex === index && styles.paginationDotActive
                        ]}
                    />
                ))}
            </View>

            <TouchableOpacity
                style={styles.viewMoreButton}
                activeOpacity={0.7}
                onPress={() => router.push("History/HistoryListView")}
            >
                <Text style={styles.viewMoreText}>View More</Text>
            </TouchableOpacity>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#f8f9fa',
    },
    title: {
        fontSize: 28,
        fontWeight: '700',
        color: '#1a1a1a',
        textAlign: 'center',
        marginVertical: 20,
        letterSpacing: 0.5,
    },
    scrollContainer: {
        paddingBottom: 20,
    },
    card: {
        width: CARD_WIDTH,
        padding: 20,
        marginHorizontal: SPACING,
        backgroundColor: '#ffffff',
        borderRadius: 20,
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 2 },
        shadowOpacity: 0.1,
        shadowRadius: 10,
        elevation: 5,
    },
    cardHeader: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        marginBottom: 12,
    },
    visitorName: {
        fontSize: 20,
        fontWeight: '600',
        color: '#1a1a1a',
    },
    statusBadge: {
        paddingHorizontal: 12,
        paddingVertical: 6,
        borderRadius: 12,
    },
    statusText: {
        color: '#fff',
        fontSize: 12,
        fontWeight: '600',
    },
    message: {
        fontSize: 16,
        color: '#4a4a4a',
        marginBottom: 12,
        lineHeight: 22,
    },
    time: {
        fontSize: 14,
        color: '#888',
        fontWeight: '500',
    },
    pagination: {
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center',
        paddingVertical: 20,
    },
    paginationDot: {
        width: 8,
        height: 8,
        borderRadius: 4,
        backgroundColor: '#ddd',
        marginHorizontal: 4,
    },
    paginationDotActive: {
        backgroundColor: Colors.BUTTON,
        width: 20,
    },
    viewMoreButton: {
        backgroundColor: Colors.BUTTON,
        paddingVertical: 12,
        paddingHorizontal: 24,
        borderRadius: 25,
        marginHorizontal: 40,
        marginBottom: 20,
        alignItems: 'center',
    },
    viewMoreText: {
        color: '#ffffff',
        fontSize: 16,
        fontWeight: '600',
    },
});